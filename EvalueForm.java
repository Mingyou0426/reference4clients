package churn;

import javax.swing.table.TableModel;
import javax.swing.GroupLayout.Alignment;
import javax.swing.GroupLayout;
import java.awt.Font;
import java.awt.Toolkit;

import javax.swing.JTextField;
import javax.swing.JLabel;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import weka.core.Instances;
import weka.core.converters.ArffSaver;
import weka.core.converters.CSVLoader;

import java.awt.Dimension;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.SwingConstants;
import javax.swing.JTextArea;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JScrollPane;
import javax.swing.JTable;

public class EvalueForm extends javax.swing.JFrame {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
     * Genera un nuovo form: ManageLezioniForm
     */
//	Dataset volo = new Dataset();
	File selectedTrainFile;
	File selectedTestFile;
//    String pathTrain = "/Users/angelocianci/dataset/churntrain.csv";
//    String pathTest = "/Users/angelocianci/dataset/churntest.csv";
//   
//    String pathTrainArff = "/Users/angelocianci/dataset/churntrain.arff";
//    String pathTestArff = "/Users/angelocianci/dataset/churntest.arff";
    
    String pathTrain = "E:\\ming\\angelod\\testdata\\datasetok-train.csv";
    String pathTest = "E:\\ming\\angelod\\testdata\\datasetok-test.csv";
   
    String pathTrainArff = "E:\\ming\\angelod\\testdata\\churntrain.arff";
    String pathTestArff = "E:\\ming\\angelod\\testdata\\churntest.arff";
    
    ManageClusterForm mcform;
    
    public EvalueForm() {
    	setTitle("Clustering");
    	getContentPane().setPreferredSize(new Dimension(870, 620));
    	setResizable(false);
        initComponents();
       
//        ClusteringButton.setBounds(218, 522, 129, 29);
//        jPanel1.add(ClusteringButton);
        
        TrainButton = new JButton("Select Train File");
        TrainButton.setBounds(5, 50, 130, 30);
        jPanel1.add(TrainButton);
        TrainButton.addActionListener(new ActionListener() {
        	public void actionPerformed(ActionEvent e) {
        		JFileChooser fileChooser = new JFileChooser();
        	    int returnValue = fileChooser.showOpenDialog(null);
        	    if (returnValue == JFileChooser.APPROVE_OPTION) {
        	    	selectedTrainFile = fileChooser.getSelectedFile();
        	    	textAreaTrainFile.setText(selectedTrainFile.toString());
        	    }
        	}
        });
        
        textAreaTrainFile = new JTextArea();
        textAreaTrainFile.setEditable(false);
        textAreaTrainFile.setBounds(140, 50, 500, 30);
        jPanel1.add(textAreaTrainFile);      

        TestButton = new JButton("Select Test File");
        TestButton.setBounds(5, 100, 130, 30);
        jPanel1.add(TestButton);        
        TestButton.addActionListener(new ActionListener() {
        	public void actionPerformed(ActionEvent e) {
        		JFileChooser fileChooser = new JFileChooser();
        	    int returnValue = fileChooser.showOpenDialog(null);
        	    if (returnValue == JFileChooser.APPROVE_OPTION) {
        	    	selectedTestFile = fileChooser.getSelectedFile();
        	    	textAreaTestFile.setText(selectedTestFile.toString());
        	    }
        	}
        });
        
        textAreaTestFile = new JTextArea();
        textAreaTestFile.setEditable(false);
        textAreaTestFile.setBounds(140, 100, 500, 30);
        jPanel1.add(textAreaTestFile);
        
//        JLabel LabelParametri = new JLabel("Cluster Number");
//        LabelParametri.setBounds(10, 150, 100, 20);
//        jPanel1.add(LabelParametri);
//        
//        textFieldCluster = new JTextField();
//        textFieldCluster.setBounds(120, 145, 200, 30);
//        jPanel1.add(textFieldCluster);
//        textFieldCluster.setColumns(10);
        
        OutputTextArea = new JTextArea();        
        OutputScrollPane = new JScrollPane();
        OutputScrollPane.setBounds(10, 150, 600, 450);
        jPanel1.add(OutputScrollPane);
        OutputScrollPane.setViewportView(OutputTextArea);
        PrintStream printStream = new PrintStream(new ChurnOutput(OutputTextArea));
                
        EvalueButton = new JButton("Evalue Clustering");
        EvalueButton.setBounds(650, 185, 200, 30);
        jPanel1.add(EvalueButton);        
        EvalueButton.addActionListener(new ActionListener() {
        	public void actionPerformed(ActionEvent e) {
        		try {
        			Connection con = clustering.getConnection();
        			Statement stmt = con.createStatement();
        			String query = "select count(*) cnt from datacluster";
        			ResultSet rs = stmt.executeQuery(query);
        			int numcluster = 0;
        			
        			if ( rs.next() )
        				numcluster = rs.getInt("cnt");
        			clustering.clusterids = new int[numcluster];
        			query = "select * from datacluster";
        			rs = stmt.executeQuery(query);
        			
        			int i = 0;
        			while ( rs.next() ) {
        				clustering.clusterids[i++] = rs.getInt("clusterid");
        			}
        			
        			if ( rs!=null ) rs.close();
        			if ( stmt!=null ) stmt.close();
        			if ( con!=null ) con.close();
        			
        			clustering.clustering(selectedTrainFile, selectedTestFile,numcluster,1);
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
        	}
        });
        
        ActionClusterButton = new JButton("Cluster Action");
        ActionClusterButton.setBounds(650, 225, 200, 30);
        jPanel1.add(ActionClusterButton);        
        ActionClusterButton.addActionListener(new ActionListener() {
        	public void actionPerformed(ActionEvent e) {
        		try {
        			mcform.setVisible(true);
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
        	}
        });
        
        System.setOut(printStream);
        System.setErr(printStream);
        
        try {
			mcform = new ManageClusterForm();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
   
    
    private void initComponents() {
        jPanel1 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        jLabel1.setHorizontalAlignment(SwingConstants.CENTER);
        new javax.swing.JLabel();
        new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.HIDE_ON_CLOSE);

        jPanel1.setBackground(new java.awt.Color(153, 153, 153));
        jPanel1.setLayout(null);

        jPanel2.setBackground(new java.awt.Color(204, 0, 0));

        jLabel1.setFont(new Font("Calibri", Font.BOLD, 18)); // NOI18N
        jLabel1.setText("Evaluate Clustering");

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2Layout.setHorizontalGroup(
        	jPanel2Layout.createParallelGroup(Alignment.TRAILING)
        		.addGroup(Alignment.LEADING, jPanel2Layout.createSequentialGroup()
        			.addGap(306)
        			.addComponent(jLabel1, GroupLayout.PREFERRED_SIZE, 294, GroupLayout.PREFERRED_SIZE)
        			.addContainerGap(300, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
        	jPanel2Layout.createParallelGroup(Alignment.LEADING)
        		.addGroup(jPanel2Layout.createSequentialGroup()
        			.addContainerGap()
        			.addComponent(jLabel1, GroupLayout.PREFERRED_SIZE, 32, GroupLayout.PREFERRED_SIZE)
        			.addContainerGap(44, Short.MAX_VALUE))
        );
        jPanel2.setLayout(jPanel2Layout);

        jPanel1.add(jPanel2);
        jPanel2.setBounds(0, 0, 900, 40);

	    javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
	    layout.setHorizontalGroup(
	    	layout.createParallelGroup(Alignment.LEADING)
	    		.addComponent(jPanel1, GroupLayout.DEFAULT_SIZE, 900, Short.MAX_VALUE)
	    );
	    layout.setVerticalGroup(
	    	layout.createParallelGroup(Alignment.LEADING)
	    		.addGroup(layout.createSequentialGroup()
	    			.addComponent(jPanel1, GroupLayout.PREFERRED_SIZE, 675, GroupLayout.PREFERRED_SIZE)
	    			.addContainerGap(125, Short.MAX_VALUE))
	    );
	    getContentPane().setLayout(layout);
	
	    pack();
	    
	    Dimension dim = Toolkit.getDefaultToolkit().getScreenSize();
	    this.setLocation(dim.width/2-this.getSize().width/2, dim.height/2-this.getSize().height/2);
    }
    
    public static boolean exportTrainToCSV(JTable tableToExport,String pathToExportTo) {
        try {
            TableModel model = tableToExport.getModel();
            FileWriter csv = new FileWriter(new File(pathToExportTo));
            int i = 0;
            int j = 0;
            for (i = 0; i < (model.getColumnCount()-1); i++) {
                csv.write(model.getColumnName(i) + ",");
            }
            csv.write(model.getColumnName(i));
            csv.write("\n");
            for (i = 0; i < model.getRowCount()*0.4; i++) {
                for (j = 0; j < model.getColumnCount()-1; j++) {
                    csv.write(model.getValueAt(i, j).toString() + ",");
                }
                csv.write(model.getValueAt(i, j).toString());
                csv.write("\n");
            }

            csv.close();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }
   
    public static boolean exportTestToCSV(JTable tableToExport,String pathToExportTo) {
        try {

            TableModel model = tableToExport.getModel();
            FileWriter csv = new FileWriter(new File(pathToExportTo));
            int i = 0;
            int j = 0;
            for (i = 0; i < (model.getColumnCount()-1); i++) {
                csv.write(model.getColumnName(i) + ",");
            }
            csv.write(model.getColumnName(i));
            csv.write("\n");
            for (i = (int) ((model.getRowCount()*0.4)+1); i < model.getRowCount(); i++) {
                for (j = 0; j < model.getColumnCount()-1; j++) {
                    csv.write(model.getValueAt(i, j).toString() + ",");
                }
                csv.write(model.getValueAt(i, j).toString());
                csv.write("\n");
            }

            csv.close();
            return true;
            
            
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean CsvTrainToArff() {
        try {
            
            // load the CSV file (input file)
            CSVLoader loader = new CSVLoader();
            loader.setSource(new File(pathTrain));
            String [] options = new String[1];
            options[0]="-H";
            loader.setOptions(options);

            Instances data = loader.getDataSet();
            System.out.println(data);

            // save as an  ARFF (output file)
            ArffSaver saver = new ArffSaver();
            saver.setInstances(data);
            saver.setFile(new File(pathTrainArff));
            saver.setDestination(new File(pathTrainArff));
            saver.writeBatch();
            return true;
        } catch(Exception e) {
        	return false;
        }
    }
    
    public boolean CsvTestToArff() {
        try {
            // load the CSV file (input file)
            CSVLoader loader = new CSVLoader();
            loader.setSource(new File(pathTest));
            String [] options = new String[1];
            options[0]="-H";
            loader.setOptions(options);

            Instances data = loader.getDataSet();
            System.out.println(data);

            // save as an  ARFF (output file)
            ArffSaver saver = new ArffSaver();
            saver.setInstances(data);
            saver.setFile(new File(pathTestArff));
            saver.setDestination(new File(pathTestArff));
            saver.writeBatch();
            return true;
        } catch(Exception e) {
        	return false;
        } 
    }
 
    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(EvalueForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(EvalueForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(EvalueForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(EvalueForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Crea e visualizza il form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                
            	new EvalueForm().setVisible(true);
            	//System.out.println("test");
            	
            }
        });
    }
    
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    
    private JButton TrainButton;
//    private JButton ClusteringButton;
    private JButton EvalueButton;
    private JButton ActionClusterButton;
    
    private JScrollPane OutputScrollPane;
    private JTextArea OutputTextArea;
    private JButton TestButton;
    
    private JTextArea textAreaTrainFile;
    private JTextArea textAreaTestFile;
//    private JTextField textFieldCluster;
}
